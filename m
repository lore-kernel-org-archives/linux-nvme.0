From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 31 Jul 2016 11:45:15 +0300
Subject: [PATCH 2/2] nvme-rdma: Add handling for connecting to IPv6 targets
In-Reply-To: <1469950060-18098-2-git-send-email-roland@kernel.org>
References: <1469950060-18098-1-git-send-email-roland@kernel.org>
 <1469950060-18098-2-git-send-email-roland@kernel.org>
Message-ID: <4acdd466-b8f6-8208-7287-e97dfd45bbf1@grimberg.me>



On 31/07/16 10:27, Roland Dreier wrote:
> From: Roland Dreier <roland at purestorage.com>
>
> If a target address does not parse as IPv4, try parsing it as IPv6
> (including handling '%<scope-id>' suffixes for link-local addresses).
>
> Signed-off-by: Roland Dreier <roland at purestorage.com>


Nice! thanks Roland,

testing it now...
