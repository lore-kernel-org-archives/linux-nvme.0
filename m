From: keith.busch@intel.com (Keith Busch)
Date: Thu, 17 Nov 2016 11:29:25 -0500
Subject: [PATCH 1/3] update discover and connect-all man pages
In-Reply-To: <1479394343-4940-2-git-send-email-hch@lst.de>
References: <1479394343-4940-1-git-send-email-hch@lst.de>
 <1479394343-4940-2-git-send-email-hch@lst.de>
Message-ID: <20161117162924.GI10050@localhost.localdomain>

On Thu, Nov 17, 2016@03:52:21PM +0100, Christoph Hellwig wrote:
> Document the --host-traddr option, and add the missing description of
> the --raw command to the connect-all man page.

This isn't quite merged up to the latest. The short option for host-traddr
needed to change since -s is already used.
 
> +		[--transport=<trtype>     | -t <trtype>]
> +		[--traddr=<traddr>        | -a <traddr>]
> +		[--trsvcid=<trsvcid>      | -s <trsvcid>]
> +		[--host_traddr=<traddr>   | -s <traddr>]
> +		[--hostnqn=<hostnqn>      | -q <hostnqn>]
> +		[--raw=<filename>         | -r <filename>]
