From: keith.busch@intel.com (Keith Busch)
Date: Thu, 23 Jul 2015 20:11:18 +0000 (UTC)
Subject: nvme-cli format timeout
In-Reply-To: <55B14899.5000407@ranbarg.com>
References: <55B14899.5000407@ranbarg.com>
Message-ID: <alpine.LNX.2.00.1507232009580.15930@localhost.lm.intel.com>

On Thu, 23 Jul 2015, Paul Grabinar wrote:
> Hi,
>
> I am aware of some NVMe drives that take well over 60 seconds to perform
> a format and therefore timeout during the format command issued by nvme-cli.
>
> We might want to consider increasing the timeout. The following patch is
> an example to show what I mean.

Good idea. We should probably make this a parameter as well as up
the timeout. Only the passthru command takes the timeout request as a
parameter for some reason.

If you want to post a pull request on github, we can apply it from there.
