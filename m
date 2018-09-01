From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sat, 1 Sep 2018 20:40:09 +0000
Subject: [PATCH nvme-cli 3/4] nvme: commonize subsystems info in a helper
In-Reply-To: <20180901013605.10658-4-sagi@grimberg.me>
References: <20180901013605.10658-1-sagi@grimberg.me>
 <20180901013605.10658-4-sagi@grimberg.me>
Message-ID: <0678BE8F-E637-493D-B08F-01577E92E56C@wdc.com>

Looks good to me. (not sure if it matters but we can go up to 72 columns for commit log,
if it does can be fixed at the time of applying the patch).

Reviewed-by : Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>.

On 8/31/18, 6:37 PM, "Linux-nvme on behalf of Sagi Grimberg" <linux-nvme-bounces@lists.infradead.org on behalf of sagi@grimberg.me> wrote:

    We will want that to reuse for other ops that
    will require to scan subsystems or controllers
    
    Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
    ---
     nvme.c | 77 ++++++++++++++++++++++++++++++++--------------------------
     nvme.h |  2 ++
     2 files changed, 44 insertions(+), 35 deletions(-)
    
    diff --git a/nvme.c b/nvme.c
    index d7be2e04c9f4..80422516e6ad 100644
    --- a/nvme.c
    +++ b/nvme.c
    @@ -1498,7 +1498,7 @@ static void free_subsys_list_item(struct subsys_list_item *item)
     	free(item->name);
     }
     
    -static void free_subsys_list(struct subsys_list_item *slist, int n)
    +void free_subsys_list(struct subsys_list_item *slist, int n)
     {
     	int i;
     
    @@ -1508,13 +1508,50 @@ static void free_subsys_list(struct subsys_list_item *slist, int n)
     	free(slist);
     }
     
    -static int list_subsys(int argc, char **argv, struct command *cmd,
    -		       struct plugin *plugin)
    +struct subsys_list_item *get_subsys_list(int *subcnt)
     {
     	char path[310];
     	struct dirent **subsys;
     	struct subsys_list_item *slist;
    -	int fmt, n, i, ret = 0, subcnt = 0;
    +	int n, i, ret = 0;
    +
    +	n = scandir(subsys_dir, &subsys, scan_subsys_filter, alphasort);
    +	if (n < 0) {
    +		fprintf(stderr, "no NVMe subsystem(s) detected.\n");
    +		return NULL;
    +	}
    +
    +	slist = calloc(n, sizeof(struct subsys_list_item));
    +	if (!slist)
    +		goto free_subsys;
    +
    +	for (i = 0; i < n; i++) {
    +		snprintf(path, sizeof(path), "%s%s", subsys_dir,
    +			subsys[i]->d_name);
    +		ret = get_nvme_subsystem_info(subsys[i]->d_name, path,
    +				&slist[*subcnt]);
    +		if (ret) {
    +			fprintf(stderr,
    +				"%s: failed to get subsystem info: %s\n",
    +				path, strerror(errno));
    +			free_subsys_list_item(&slist[*subcnt]);
    +		} else
    +			(*subcnt)++;
    +	}
    +
    +free_subsys:
    +	for (i = 0; i < n; i++)
    +		free(subsys[i]);
    +	free(subsys);
    +
    +	return slist;
    +}
    +
    +static int list_subsys(int argc, char **argv, struct command *cmd,
    +		struct plugin *plugin)
    +{
    +	struct subsys_list_item *slist;
    +	int fmt, ret, subcnt = 0;
     	const char *desc = "Retrieve information for subsystems";
     	struct config {
     		char *output_format;
    @@ -1535,47 +1572,17 @@ static int list_subsys(int argc, char **argv, struct command *cmd,
     		return ret;
     
     	fmt = validate_output_format(cfg.output_format);
    -
     	if (fmt != JSON && fmt != NORMAL)
     		return -EINVAL;
    -	n = scandir(subsys_dir, &subsys, scan_subsys_filter, alphasort);
    -	if (n < 0) {
    -		fprintf(stderr, "no NVMe subsystem(s) detected.\n");
    -		return n;
    -	}
     
    -	slist = calloc(n, sizeof(struct subsys_list_item));
    -	if (!slist) {
    -		ret = ENOMEM;
    -		goto free_subsys;
    -	}
    -
    -	for (i = 0; i < n; i++) {
    -		snprintf(path, sizeof(path), "%s%s", subsys_dir,
    -			subsys[i]->d_name);
    -		ret = get_nvme_subsystem_info(subsys[i]->d_name, path,
    -				&slist[subcnt]);
    -		if (ret) {
    -			fprintf(stderr,
    -				"%s: failed to get subsystem info: %s\n",
    -				path, strerror(errno));
    -			free_subsys_list_item(&slist[subcnt]);
    -		} else
    -			subcnt++;
    -	}
    +	slist = get_subsys_list(&subcnt);
     
     	if (fmt == JSON)
     		json_print_nvme_subsystem_list(slist, subcnt);
     	else
     		show_nvme_subsystem_list(slist, subcnt);
     
    -free_subsys:
     	free_subsys_list(slist, subcnt);
    -
    -	for (i = 0; i < n; i++)
    -		free(subsys[i]);
    -	free(subsys);
    -
     	return ret;
     }
     
    diff --git a/nvme.h b/nvme.h
    index 5098b0ef9c7c..e509e9c64f05 100644
    --- a/nvme.h
    +++ b/nvme.h
    @@ -155,4 +155,6 @@ extern const char *devicename;
     int __id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin, void (*vs)(__u8 *vs, struct json_object *root));
     int	validate_output_format(char *format);
     
    +struct subsys_list_item *get_subsys_list(int *subcnt);
    +void free_subsys_list(struct subsys_list_item *slist, int n);
     #endif /* _NVME_H */
    -- 
    2.17.1
    
    
    _______________________________________________
    Linux-nvme mailing list
    Linux-nvme at lists.infradead.org
    http://lists.infradead.org/mailman/listinfo/linux-nvme
    
