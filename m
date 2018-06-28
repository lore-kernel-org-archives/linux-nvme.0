From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 28 Jun 2018 17:38:03 +0300
Subject: [PATCH v2 1/1] nvmet-rdma: Add error flow for post_recv failures
In-Reply-To: <1530100713-24247-1-git-send-email-maxg@mellanox.com>
References: <1530100713-24247-1-git-send-email-maxg@mellanox.com>
Message-ID: <40da9af2-9adb-62d4-223e-62d94186269b@grimberg.me>


> Posting receive buffer operation can fail, thus we should
> make sure there is no memory leakage in that flow. Also add
> an error log in case of a failure.

What memory leak? resulting from post_recv errors?
