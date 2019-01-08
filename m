From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon,  7 Jan 2019 23:55:31 -0800
Subject: [PATCH nvme-cli] fabrics: allow nr_io/write/poll_queues and queue
 size to discovery
Message-ID: <20190108075531.4280-1-sagi@grimberg.me>

The discovered controllers will inherit the arguments.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 fabrics.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index 46edacab110f..594789b28dde 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -969,6 +969,10 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 		{"ctrl-loss-tmo",   'l', "LIST", CFG_INT, &cfg.ctrl_loss_tmo,   required_argument, "controller loss timeout period in seconds" },
 		{"hdr_digest", 'g', "", CFG_NONE, &cfg.hdr_digest, no_argument, "enable transport protocol header digest (TCP transport)" },
 		{"data_digest", 'G', "", CFG_NONE, &cfg.data_digest, no_argument, "enable transport protocol data digest (TCP transport)" },
+		{"nr-io-queues",    'i', "LIST", CFG_INT, &cfg.nr_io_queues,    required_argument, "number of io queues to use (default is core count)" },
+		{"nr-write-queues", 'W', "LIST", CFG_INT, &cfg.nr_write_queues,    required_argument, "number of write queues to use (default 0)" },
+		{"nr-poll-queues",  'P', "LIST", CFG_INT, &cfg.nr_poll_queues,    required_argument, "number of poll queues to use (default 0)" },
+		{"queue-size",      'Q', "LIST", CFG_INT, &cfg.queue_size,      required_argument, "number of io queue elements to use (default 128)" },
 		{NULL},
 	};
 
-- 
2.17.1
