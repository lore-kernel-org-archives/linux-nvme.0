From: keith.busch@intel.com (Keith Busch)
Date: Tue, 11 Dec 2018 12:30:15 -0700
Subject: [PATCH nvme-cli 6/5] fabrics: pass in nr_write_queues
In-Reply-To: <20181211104936.25333-7-sagi@grimberg.me>
References: <20181211104936.25333-1-sagi@grimberg.me>
 <20181211104936.25333-7-sagi@grimberg.me>
Message-ID: <20181211193015.GC8101@localhost.localdomain>

On Tue, Dec 11, 2018@02:49:36AM -0800, Sagi Grimberg wrote:
>  	if (cfg.host_traddr) {
>  		len = sprintf(p, ",host_traddr=%s", cfg.host_traddr);
>  		if (len < 0)
> @@ -1009,6 +1019,7 @@ int connect(const char *desc, int argc, char **argv)
>  		{"hostnqn",         'q', "LIST", CFG_STRING, &cfg.hostnqn,         required_argument, "user-defined hostnqn" },
>  		{"hostid",          'I', "LIST", CFG_STRING, &cfg.hostid,      required_argument, "user-defined hostid (if default not used)"},
>  		{"nr-io-queues",    'i', "LIST", CFG_INT, &cfg.nr_io_queues,    required_argument, "number of io queues to use (default is core count)" },
> +		{"nr_write_queues",  'W', "LIST", CFG_INT, &cfg.nr_write_queues,    required_argument, "number of write queues to use (default 0)" },

I realize the kernel's nvme-admin uses "_", but everything else in the
shell utility here uses "-", so just want to use that for consistency.
And the documentation needs to include this as well.

Otherwise this is great.
