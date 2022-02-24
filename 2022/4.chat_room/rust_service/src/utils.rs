pub mod my_utils {
    pub async fn get_timestamp() -> i64 {
        let now = std::time::SystemTime::now();
        let since_epoch = now
            .duration_since(std::time::UNIX_EPOCH)
            .unwrap()
            .as_millis();
        return since_epoch as i64;
    }
}
