use super::models::*;
use crate::templates::OptUser;

use crate::users::models::User;

#[derive(Template)]
#[template(path = "project/project.html")]
pub struct ProjectTemplate {
    pub logged_in: OptUser,
    pub project: Project,
    pub repos: Vec<String>,
}

#[derive(Template)]
#[template(path = "project/new-project.html")]
pub struct NewProjectTemplate {
    pub logged_in: OptUser,
}

#[derive(Template)]
#[template(path = "project/edit-project.html")]
pub struct EditProjectTemplate {
    pub logged_in: OptUser,
    pub project: Project,
    pub repos: Vec<String>,
    pub all_users: Vec<User>,
}

#[derive(Template)]
#[template(path = "project/projects-list.html")]
pub struct ProjectsListTemplate {
    pub logged_in: OptUser,
    pub projects: Vec<Project>,
}