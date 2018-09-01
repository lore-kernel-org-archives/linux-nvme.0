From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sat, 1 Sep 2018 20:40:25 +0000
Subject: [PATCH nvme-cli 4/4] fabrics: add disconnect-all command
In-Reply-To: <20180901013605.10658-5-sagi@grimberg.me>
References: <20180901013605.10658-1-sagi@grimberg.me>
 <20180901013605.10658-5-sagi@grimberg.me>
Message-ID: <8B18BAFD-12AE-4EE8-91DC-77B2B8CFF5ED@wdc.com>

Just one minor comment, otherwise looks good to me.

Reviewed-by : Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>.

On 8/31/18, 6:38 PM, "Linux-nvme on behalf of Sagi Grimberg" <linux-nvme-bounces@lists.infradead.org on behalf of sagi@grimberg.me> wrote:

    Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
    ---
     Documentation/nvme-disconnect-all.txt | 34 +++++++++++++++++++++++++++
     fabrics.c                             | 29 +++++++++++++++++++++++
     fabrics.h                             |  1 +
     nvme-builtin.h                        |  1 +
     nvme.c                                |  6 +++++
     5 files changed, 71 insertions(+)
     create mode 100644 Documentation/nvme-disconnect-all.txt
    
    diff --git a/Documentation/nvme-disconnect-all.txt b/Documentation/nvme-disconnect-all.txt
    new file mode 100644
    index 000000000000..6be7e414dea7
    --- /dev/null
    +++ b/Documentation/nvme-disconnect-all.txt
    @@ -0,0 +1,34 @@
    +nvme-disconnect-all(1)
    +======================
    +
    +NAME
    +----
    +nvme-disconnect-all - Disconnect from all connected Fabrics controllers.
    +
    +SYNOPSIS
    +--------
    +[verse]
    +'nvme disconnect-all'
    +
    +DESCRIPTION
    +-----------
    +Disconnects and removes all existing NVMe over Fabrics controllers.
    +
    +See the documentation for the nvme-disconnect(1) command for further
    +background.
    +
    +EXAMPLES
    +--------
    +* Disconnect all existing nvme controllers:
[CK] Even though it's implied may be add "NVMe over Fabrics" in the above line ?
    ++
    +------------
    +# nvme disconnect-all
    +------------
    +
    +SEE ALSO
    +--------
    +nvme-disconnect(1)
    +
    +NVME
    +----
    +Part of the nvme-user suite
    diff --git a/fabrics.c b/fabrics.c
    index 09cb97c5b880..029105b227ff 100644
    --- a/fabrics.c
    +++ b/fabrics.c
    @@ -1048,3 +1048,32 @@ int disconnect(const char *desc, int argc, char **argv)
     
     	return ret;
     }
    +
    +int disconnect_all(const char *desc, int argc, char **argv)
    +{
    +	struct subsys_list_item *slist;
    +	int i, j, ret = 0, subcnt = 0;
    +	const struct argconfig_commandline_options command_line_options[] = {
    +		{NULL},
    +	};
    +
    +	ret = argconfig_parse(argc, argv, desc, command_line_options, &cfg,
    +			sizeof(cfg));
    +	if (ret)
    +		return ret;
    +
    +	slist = get_subsys_list(&subcnt);
    +	for (i = 0; i < subcnt; i++) {
    +		struct subsys_list_item *subsys = &slist[i];
    +
    +		for (j = 0; j < subsys->nctrls; j++) {
    +			struct ctrl_list_item *ctrl = &subsys->ctrls[j];
    +
    +			ret = disconnect_by_device(ctrl->name);
    +			if (ret)
    +				goto out;
    +		}
    +	}
    +out:
    +	return ret;
    +}
    diff --git a/fabrics.h b/fabrics.h
    index 91aec90f0ab0..988f3ef2fbc4 100644
    --- a/fabrics.h
    +++ b/fabrics.h
    @@ -4,5 +4,6 @@
     extern int discover(const char *desc, int argc, char **argv, bool connect);
     extern int connect(const char *desc, int argc, char **argv);
     extern int disconnect(const char *desc, int argc, char **argv);
    +extern int disconnect_all(const char *desc, int argc, char **argv);
     
     #endif
    diff --git a/nvme-builtin.h b/nvme-builtin.h
    index f9e47b33803c..afd12b055910 100644
    --- a/nvme-builtin.h
    +++ b/nvme-builtin.h
    @@ -63,6 +63,7 @@ COMMAND_LIST(
     	ENTRY("connect-all", "Discover and Connect to NVMeoF subsystems", connect_all_cmd)
     	ENTRY("connect", "Connect to NVMeoF subsystem", connect_cmd)
     	ENTRY("disconnect", "Disconnect from NVMeoF subsystem", disconnect_cmd)
    +	ENTRY("disconnect-all", "Disconnect from all connected NVMeoF subsystems", disconnect_all_cmd)
     	ENTRY("gen-hostnqn", "Generate NVMeoF host NQN", gen_hostnqn_cmd)
     	ENTRY("dir-receive", "Submit a Directive Receive command, return results", dir_receive)
     	ENTRY("dir-send", "Submit a Directive Send command, return results", dir_send)
    diff --git a/nvme.c b/nvme.c
    index 80422516e6ad..a17a4f9393dc 100644
    --- a/nvme.c
    +++ b/nvme.c
    @@ -4624,6 +4624,12 @@ static int disconnect_cmd(int argc, char **argv, struct command *command, struct
     	return disconnect(desc, argc, argv);
     }
     
    +static int disconnect_all_cmd(int argc, char **argv, struct command *command, struct plugin *plugin)
    +{
    +	const char *desc = "Disconnect from all connected NVMeoF subsystems";
    +	return disconnect_all(desc, argc, argv);
    +}
    +
     void register_extension(struct plugin *plugin)
     {
     	plugin->parent = &nvme;
    -- 
    2.17.1
    
    
    _______________________________________________
    Linux-nvme mailing list
    Linux-nvme at lists.infradead.org
    http://lists.infradead.org/mailman/listinfo/linux-nvme
    
