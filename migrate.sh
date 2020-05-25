#!/bin/bash

# Clear cache
drush cr

# Create Migrations
drush --yes migrate:upgrade --legacy-db-key migrate --legacy-root /var/www/multisite --configure-only

# Export migration configuration
drush --yes config:export

# Clear/Rebuild cache
drush cr

# Migrate some configurations
drush mim upgrade_d7_dblog_settings,upgrade_d7_filter_settings,upgrade_d7_global_theme_settings,upgrade_d7_image_settings
drush mim upgrade_d7_node_settings,upgrade_d7_pathauto_settings,upgrade_d7_search_settings,upgrade_d7_syslog_settings,upgrade_d7_system_authorize
drush mim upgrade_d7_system_cron,upgrade_d7_system_date,upgrade_d7_system_file,upgrade_d7_system_mail,upgrade_d7_system_performance

# Migrate user roles and users
drush mim upgrade_d7_user_role
drush mim upgrade_d7_user

# Migrate Taxonomy vocabulary and terms
drush mim upgrade_d7_taxonomy_vocabulary
drush mim upgrade_d7_taxonomy_term_fieldwork_discipline,upgrade_d7_taxonomy_term_tutorials,upgrade_d7_taxonomy_term_faq_categories
drush mim upgrade_d7_taxonomy_term_minutes_tag,upgrade_d7_taxonomy_term_sciencekeywordss9_669,upgrade_d7_taxonomy_term_sciencekeywords8_3963
drush mim upgrade_d7_taxonomy_term_sciencekeywords6_2052,upgrade_d7_taxonomy_term__partner_in_application_,upgrade_d7_taxonomy_term_intranet_tag
drush mim upgrade_d7_taxonomy_term_wigos_1_01,upgrade_d7_taxonomy_term_sios_institution_role,upgrade_d7_taxonomy_term_sios_person_role
drush mim upgrade_d7_taxonomy_term_tags,upgrade_d7_taxonomy_term_envri_fair_topics

# Migrate more configurations 
drush mim upgrade_d7_theme_settings,upgrade_d7_user_flood,upgrade_d7_user_mail,upgrade_file_settings,upgrade_menu_settings
drush mim upgrade_d7_image_styles,upgrade_d7_search_page,upgrade_system_image,upgrade_system_image_gd,upgrade_system_logging,upgrade_system_maintenance
drush mim upgrade_system_rss,upgrade_system_site,upgrade_taxonomy_settings,upgrade_text_settings,upgrade_update_settings
drush mim upgrade_block_content_type,upgrade_block_content_body_field,upgrade_block_content_entity_display,upgrade_block_content_entity_form_display

# Update some migrations
drush mim --update upgrade_d7_color,upgrade_d7_theme_settings

# Migrate filter fortmat. NOTE: collapse_text fails. need to manually edit filterformats and assign editor and rearrange,
drush mim upgrade_d7_filter_format
read -rsp $'NOTE: Fix filter format settings in webgui,add collapse_text filter and rearrange\nPress any key to continue...\n' -n1 key

# Continue migrations
drush mim upgrade_d7_custom_block
drush mim upgrade_d7_custom_block
drush mim upgrade_d7_block
drush mim upgrade_d7_field
drush mim upgrade_d7_field_collection_type
drush mim upgrade_d7_node_type,upgrade_d7_comment_type

# Migrate the field instances
drush mim upgrade_d7_field_instance

# Migrate public files
drush mim upgrade_d7_file
read -rsp $'NOTE: files should be manually copied/replaced to the right place after migrations \nPress any key to continue...\n' -n1 key


# Migrate user config and update users
drush mim upgrade_user_picture_field,upgrade_user_picture_field_instance,upgrade_user_picture_entity_display,upgrade_user_picture_entity_form_display
drush mim --update upgrade_d7_user

# Migrate comment fields and intances
drush mim upgrade_d7_comment_field,upgrade_d7_comment_field_instance

# Migrate CONTENT
drush mim upgrade_d7_node_article
drush mim upgrade_d7_node_sios_institution
drush mim upgrade_d7_node_poll
drush mim upgrade_d7_node_page
drush mim upgrade_d7_node_webform
drush mim upgrade_d7_node_observatory_entry

# Migrate private files before sios_person
drush mim upgrade_d7_file_private

# Continue content migration
drush mim upgrade_d7_node_sios_person
drush mim upgrade_d7_node_sios_ri
drush mim upgrade_d7_node_envri_documents
drush mim upgrade_d7_node_fieldwork
drush mim upgrade_d7_node_tutorial
drush mim upgrade_d7_node_faq

# Comments migration
drush mim upgrade_d7_comment,upgrade_d7_comment_entity_display,upgrade_d7_comment_entity_form_display,upgrade_d7_comment_entity_form_display_subject

# Migrate view modes groups
drush mim upgrade_d7_view_modes

# Migrate field formatter setting. Some might fail...lets see if something can be fixed
drush mim upgrade_d7_field_formatter_settings
drush mim upgrade_d7_field_group
#NOTE SOME field instance widget settings fails...investigate 
drush mim upgrade_d7_field_instance_widget_settings

# Migrate menus
drush mim upgrade_d7_menu,upgrade_d7_menu_links

# Migrate the rest of migrations
drush mim upgrade_d7_node_revision_article,upgrade_d7_node_title_label,upgrade_d7_pathauto_patterns,upgrade_d7_rdf_mapping
drush mim upgrade_d7_shortcut_set,upgrade_d7_shortcut,upgrade_d7_shortcut_set_users
drush mim upgrade_d7_path_redirect,upgrade_d7_url_alias

# Finalize
drush updb
drush cr
