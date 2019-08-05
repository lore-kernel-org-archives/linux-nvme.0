From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 5 Aug 2019 08:10:50 -0700
Subject: [PATCH 1/2] nvme-fabrics: Add type of service (TOS) configuration
In-Reply-To: <1564912530-15404-1-git-send-email-israelr@mellanox.com>
References: <1564912530-15404-1-git-send-email-israelr@mellanox.com>
Message-ID: <04c776f4-a04a-8256-c659-daa11fe78a29@grimberg.me>


> TOS is user-defined and needs to be configured via nvme-cli.
> It must be set before initiating any traffic and once set the TOS
> cannot be changed.

Can you please have tcp support it too in the patch set (and test
that it works)?

Its simply setsockopt with SO_PRIORITY.
