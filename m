From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Dec 2018 16:27:04 -0800
Subject: [PATCH RFC nvme-cli 5/4] fabrics: pass in number of polling queues
In-Reply-To: <20181211233652.9705-6-sagi@grimberg.me>
References: <20181211233652.9705-1-sagi@grimberg.me>
 <20181211233652.9705-6-sagi@grimberg.me>
Message-ID: <c9701768-08db-6793-c31b-37ca17c404e4@grimberg.me>


> +		{"nr-poll-queues",  'W', "LIST", CFG_INT, &cfg.nr_poll_queues,    required_argument, "number of poll queues to use (default 0)" },

Oops, this should be 'P'
