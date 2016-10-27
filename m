From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 27 Oct 2016 15:14:23 +0300
Subject: [PATCH 01/12] blk-mq: Do not invoke .queue_rq() for a stopped
 queue
In-Reply-To: <1debcf7f-c950-308b-d297-3e48a77e08d7@sandisk.com>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
 <1debcf7f-c950-308b-d297-3e48a77e08d7@sandisk.com>
Message-ID: <afc6b4e8-4731-9bd0-becb-02ea20d5d3a8@grimberg.me>

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
