From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 7 Jun 2018 15:34:30 +0300
Subject: draft ANA support v3
In-Reply-To: <20180606143311.23076-1-hch@lst.de>
References: <20180606143311.23076-1-hch@lst.de>
Message-ID: <045315fe-e548-086c-fd02-ec17f395bbc3@grimberg.me>


> The big TODO list item for the kernel code is support for transition
> timeouts.
> 
> Besides that we still need nvme-cli and nvmetcli support as well as
> an automated test suite.
> 
> A git tree is available at:
> 
>      git://git.infradead.org/users/hch/block.git nvme-ana
> 
> Gitweb:
> 
>      http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-ana
> 
> Changes since v2:
>   - support changing the state for the default ANA group
>   - drop ANATT configuration again
>   - delay gendisk registration until we have an I/O capable path
>   - remove nvme_req_needs_failover and the SCT=3 handling in it,
>     we actually do the right thing without it
>   - refactor the get log page helpers

Wish you had accumulated review tags for this one...
