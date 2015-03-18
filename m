From: keith.busch@intel.com (Keith Busch)
Date: Wed, 18 Mar 2015 18:41:15 +0000 (UTC)
Subject: [PATCHv2] NVMe: Spliting large i/o in the ioctl path [for-linus
 branch]
In-Reply-To: <1424779243-14951-1-git-send-email-sathya.m@samsung.com>
References: <1424779243-14951-1-git-send-email-sathya.m@samsung.com>
Message-ID: <alpine.LNX.2.00.1503181833470.32385@localhost.lm.intel.com>

On Tue, 24 Feb 2015, Sathayavathi M wrote:
> +	for (count = 0; count < num_split_cmds; count++) {

[snip]

> +		c.rw.reftag = cpu_to_le32(io.reftag);
> +		c.rw.apptag = cpu_to_le16(io.apptag);
> +		c.rw.appmask = cpu_to_le16(io.appmask);

If the reference tag is being used, this needs to be incremented
accoringly in this loop.

Starting to think the ioctl shouldn't even bother correcting users who
request malformed commands.
