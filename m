From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sat, 1 Sep 2018 20:39:38 +0000
Subject: [PATCH nvme-cli 1/4] fabrics: make some arguments integers
In-Reply-To: <20180901013605.10658-2-sagi@grimberg.me>
References: <20180901013605.10658-1-sagi@grimberg.me>
 <20180901013605.10658-2-sagi@grimberg.me>
Message-ID: <CF1A1466-FADB-4CA2-B0C5-D16936B68E28@wdc.com>

Looks good to me, Reviewed-by : Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>.

?On 8/31/18, 6:36 PM, "Linux-nvme on behalf of Sagi Grimberg" <linux-nvme-bounces@lists.infradead.org on behalf of sagi@grimberg.me> wrote:

    Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
    ---
     fabrics.c | 60 +++++++++++++++++++++++++++++++++++--------------------
     1 file changed, 38 insertions(+), 22 deletions(-)
    
    diff --git a/fabrics.c b/fabrics.c
    index af4d7463d891..28a3e3d9ac82 100644
    --- a/fabrics.c
    +++ b/fabrics.c
    @@ -54,11 +54,11 @@ static struct config {
     	char *host_traddr;
     	char *hostnqn;
     	char *hostid;
    -	char *nr_io_queues;
    -	char *queue_size;
    -	char *keep_alive_tmo;
    -	char *reconnect_delay;
    -	char *ctrl_loss_tmo;
    +	int  nr_io_queues;
    +	int  queue_size;
    +	int  keep_alive_tmo;
    +	int  reconnect_delay;
    +	int  ctrl_loss_tmo;
     	char *raw;
     	char *device;
     	int  duplicate_connect;
    @@ -505,6 +505,22 @@ add_bool_argument(char **argstr, int *max_len, char *arg_str, bool arg)
     	return 0;
     }
     
    +static int
    +add_int_argument(char **argstr, int *max_len, char *arg_str, int arg)
    +{
    +	int len;
    +
    +	if (arg) {
    +		len = snprintf(*argstr, *max_len, ",%s=%d", arg_str, arg);
    +		if (len < 0)
    +			return -EINVAL;
    +		*argstr += len;
    +		*max_len -= len;
    +	}
    +
    +	return 0;
    +}
    +
     static int
     add_argument(char **argstr, int *max_len, char *arg_str, char *arg)
     {
    @@ -552,14 +568,14 @@ static int build_options(char *argstr, int max_len)
     		    add_argument(&argstr, &max_len, "hostnqn", cfg.hostnqn)) ||
     	    ((cfg.hostid || nvmf_hostid_file()) &&
     		    add_argument(&argstr, &max_len, "hostid", cfg.hostid)) ||
    -	    add_argument(&argstr, &max_len, "nr_io_queues",
    +	    add_int_argument(&argstr, &max_len, "nr_io_queues",
     				cfg.nr_io_queues) ||
    -	    add_argument(&argstr, &max_len, "queue_size", cfg.queue_size) ||
    -	    add_argument(&argstr, &max_len, "keep_alive_tmo",
    +	    add_int_argument(&argstr, &max_len, "queue_size", cfg.queue_size) ||
    +	    add_int_argument(&argstr, &max_len, "keep_alive_tmo",
     				cfg.keep_alive_tmo) ||
    -	    add_argument(&argstr, &max_len, "reconnect_delay",
    +	    add_int_argument(&argstr, &max_len, "reconnect_delay",
     				cfg.reconnect_delay) ||
    -	    add_argument(&argstr, &max_len, "ctrl_loss_tmo",
    +	    add_int_argument(&argstr, &max_len, "ctrl_loss_tmo",
     				cfg.ctrl_loss_tmo) ||
     	    add_bool_argument(&argstr, &max_len, "duplicate_connect",
     				cfg.duplicate_connect))
    @@ -605,14 +621,14 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
     	}
     
     	if (cfg.queue_size) {
    -		len = sprintf(p, ",queue_size=%s", cfg.queue_size);
    +		len = sprintf(p, ",queue_size=%d", cfg.queue_size);
     		if (len < 0)
     			return -EINVAL;
     		p += len;
     	}
     
     	if (cfg.nr_io_queues) {
    -		len = sprintf(p, ",nr_io_queues=%s", cfg.nr_io_queues);
    +		len = sprintf(p, ",nr_io_queues=%d", cfg.nr_io_queues);
     		if (len < 0)
     			return -EINVAL;
     		p += len;
    @@ -626,14 +642,14 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
     	}
     
     	if (cfg.ctrl_loss_tmo) {
    -		len = sprintf(p, ",ctrl_loss_tmo=%s", cfg.ctrl_loss_tmo);
    +		len = sprintf(p, ",ctrl_loss_tmo=%d", cfg.ctrl_loss_tmo);
     		if (len < 0)
     			return -EINVAL;
     		p += len;
     	}
     
     	if (cfg.keep_alive_tmo && !discover) {
    -		len = sprintf(p, ",keep_alive_tmo=%s", cfg.keep_alive_tmo);
    +		len = sprintf(p, ",keep_alive_tmo=%d", cfg.keep_alive_tmo);
     		if (len < 0)
     			return -EINVAL;
     		p += len;
    @@ -835,9 +851,9 @@ int discover(const char *desc, int argc, char **argv, bool connect)
     		{"hostnqn",     'q', "LIST", CFG_STRING, &cfg.hostnqn,     required_argument, "user-defined hostnqn (if default not used)" },
     		{"hostid",      'I', "LIST", CFG_STRING, &cfg.hostid,      required_argument, "user-defined hostid (if default not used)"},
     		{"raw",         'r', "LIST", CFG_STRING, &cfg.raw,         required_argument, "raw output file" },
    -		{"keep-alive-tmo",  'k', "LIST", CFG_STRING, &cfg.keep_alive_tmo,  required_argument, "keep alive timeout period in seconds" },
    -		{"reconnect-delay", 'c', "LIST", CFG_STRING, &cfg.reconnect_delay, required_argument, "reconnect timeout period in seconds" },
    -		{"ctrl-loss-tmo",   'l', "LIST", CFG_STRING, &cfg.ctrl_loss_tmo,   required_argument, "controller loss timeout period in seconds" },
    +		{"keep-alive-tmo",  'k', "LIST", CFG_INT, &cfg.keep_alive_tmo,  required_argument, "keep alive timeout period in seconds" },
    +		{"reconnect-delay", 'c', "LIST", CFG_INT, &cfg.reconnect_delay, required_argument, "reconnect timeout period in seconds" },
    +		{"ctrl-loss-tmo",   'l', "LIST", CFG_INT, &cfg.ctrl_loss_tmo,   required_argument, "controller loss timeout period in seconds" },
     		{NULL},
     	};
     
    @@ -872,11 +888,11 @@ int connect(const char *desc, int argc, char **argv)
     		{"host-traddr",     'w', "LIST", CFG_STRING, &cfg.host_traddr,     required_argument, "host traddr (e.g. FC WWN's)" },
     		{"hostnqn",         'q', "LIST", CFG_STRING, &cfg.hostnqn,         required_argument, "user-defined hostnqn" },
     		{"hostid",          'I', "LIST", CFG_STRING, &cfg.hostid,      required_argument, "user-defined hostid (if default not used)"},
    -		{"nr-io-queues",    'i', "LIST", CFG_STRING, &cfg.nr_io_queues,    required_argument, "number of io queues to use (default is core count)" },
    -		{"queue-size",      'Q', "LIST", CFG_STRING, &cfg.queue_size,      required_argument, "number of io queue elements to use (default 128)" },
    -		{"keep-alive-tmo",  'k', "LIST", CFG_STRING, &cfg.keep_alive_tmo,  required_argument, "keep alive timeout period in seconds" },
    -		{"reconnect-delay", 'c', "LIST", CFG_STRING, &cfg.reconnect_delay, required_argument, "reconnect timeout period in seconds" },
    -		{"ctrl-loss-tmo",   'l', "LIST", CFG_STRING, &cfg.ctrl_loss_tmo,   required_argument, "controller loss timeout period in seconds" },
    +		{"nr-io-queues",    'i', "LIST", CFG_INT, &cfg.nr_io_queues,    required_argument, "number of io queues to use (default is core count)" },
    +		{"queue-size",      'Q', "LIST", CFG_INT, &cfg.queue_size,      required_argument, "number of io queue elements to use (default 128)" },
    +		{"keep-alive-tmo",  'k', "LIST", CFG_INT, &cfg.keep_alive_tmo,  required_argument, "keep alive timeout period in seconds" },
    +		{"reconnect-delay", 'c', "LIST", CFG_INT, &cfg.reconnect_delay, required_argument, "reconnect timeout period in seconds" },
    +		{"ctrl-loss-tmo",   'l', "LIST", CFG_INT, &cfg.ctrl_loss_tmo,   required_argument, "controller loss timeout period in seconds" },
     		{"duplicate_connect", 'D', "", CFG_NONE, &cfg.duplicate_connect, no_argument, "allow duplicate connections between same transport host and subsystem port" },
     		{NULL},
     	};
    -- 
    2.17.1
    
    
    _______________________________________________
    Linux-nvme mailing list
    Linux-nvme at lists.infradead.org
    http://lists.infradead.org/mailman/listinfo/linux-nvme
    
