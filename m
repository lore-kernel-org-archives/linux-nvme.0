From: keith.busch@gmail.com (Keith Busch)
Date: Thu, 8 Aug 2019 19:57:53 -0600
Subject: [PATCH v4 2/7] nvme: return a proper errno for sync commands
 failure
In-Reply-To: <20190808232536.4258-3-sagi@grimberg.me>
References: <20190808232536.4258-1-sagi@grimberg.me>
 <20190808232536.4258-3-sagi@grimberg.me>
Message-ID: <CAOSXXT4HByc7QXdUrfGgYB93jDRKsFETUsYxw7LL7=AEsOmipQ@mail.gmail.com>

On Thu, Aug 8, 2019@5:25 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> callers should not rely on raw nvme status, instead return
> is more appropriate errno that relates to blk_status_t.

We can't readily return a negative value if the controller did provide
a real response. There are a lot of driver assumptions that a return <
0 to nvme_submit_sync_cmd() means the controller didn't provide a
response, and we should abort initialization, and >= 0 is a command
status returned from a responsive controller. I don't think there's
any driver use for specific nvme statuses, though, so returning >= 0
blk_sts_t is probably okay.
