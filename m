From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 28 May 2019 12:48:57 -0700
Subject: [PATCH 6/9] nvme: update list-subsys command to show the entire
 list
In-Reply-To: <1558951310-31066-7-git-send-email-maxg@mellanox.com>
References: <1558951310-31066-1-git-send-email-maxg@mellanox.com>
 <1558951310-31066-7-git-send-email-maxg@mellanox.com>
Message-ID: <0004494a-67a0-c010-5de6-fa66dcafff68@grimberg.me>


> Make it similar to "nvme list" command. For that, remove the
> unnecessary ana_state parsing (was introduced only if specific namespace
> handle was given).

No, this is useful! You're arbitrarily removing useful information from
the display...

nak from me on this one...
