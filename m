From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 9 Aug 2019 14:37:53 -0700
Subject: [PATCH v4 2/7] nvme: return a proper errno for sync commands
 failure
In-Reply-To: <CAOSXXT4HByc7QXdUrfGgYB93jDRKsFETUsYxw7LL7=AEsOmipQ@mail.gmail.com>
References: <20190808232536.4258-1-sagi@grimberg.me>
 <20190808232536.4258-3-sagi@grimberg.me>
 <CAOSXXT4HByc7QXdUrfGgYB93jDRKsFETUsYxw7LL7=AEsOmipQ@mail.gmail.com>
Message-ID: <b498b6b8-4e6d-3e25-1f93-4cfcdcc716d9@grimberg.me>


> We can't readily return a negative value if the controller did provide
> a real response. There are a lot of driver assumptions that a return <
> 0 to nvme_submit_sync_cmd() means the controller didn't provide a
> response, and we should abort initialization, and >= 0 is a command
> status returned from a responsive controller. I don't think there's
> any driver use for specific nvme statuses, though, so returning >= 0
> blk_sts_t is probably okay.
> 


OK, I'll go back to what you suggested earlier. Thanks Keith.
