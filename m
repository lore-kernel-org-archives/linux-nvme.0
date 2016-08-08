From: hch@lst.de (Christoph Hellwig)
Date: Mon, 8 Aug 2016 09:03:42 +0200
Subject: [PATCH RFC nvme-cli 4/4] fabrics: Allow discover params to
 come from a conf file
In-Reply-To: <1470572365-20674-5-git-send-email-sagi@grimberg.me>
References: <1470572365-20674-1-git-send-email-sagi@grimberg.me>
 <1470572365-20674-5-git-send-email-sagi@grimberg.me>
Message-ID: <20160808070342.GD12598@lst.de>

On Sun, Aug 07, 2016@03:19:25PM +0300, Sagi Grimberg wrote:
> Allow the user to just run "nvme discover" or "nvme connect-all"
> in case it finds a default /etc/nvme/nvmf_disc conf file.
> 
> We allow multiple discovery addresses by iterating over the
> lines of the file and executing a discover (with or without
> connect) for each line. We allow newlines and '#' prefixed comments.
> 
> The return value is or'ed on all discover attempts.
> 
> In order to minimize some parsing code, I just convert the
> file line into an (argc, argv) pair and feed it to argconfig_parse()
> which dictates that the file lines are identical to what one would
> pass nvme discover <params>. I'm open to better ideas.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
> Not sure if anyone will find this useful, but worth a
> shot.

Looks ok to me.  While the options are an odd config file format
having them the same as the command line at least makes it easy
to document both in one spot.

Oh, yeah - documentation.  Reminds me that I still need to deliver
the man pages for the fabrics command..

Anyway, thanks for looking into this, we really need the config
file!
