From: keith.busch@intel.com (Keith Busch)
Date: Fri, 11 Aug 2017 13:03:14 -0400
Subject: [PATCH] nvme-cli: add support for directive command
In-Reply-To: <1502420051-12378-1-git-send-email-kwan.huen@samsung.com>
References: <CGME20170811025053epcas2p1ec98081d04a0488a2c08836c909f368c@epcas2p1.samsung.com>
 <1502420051-12378-1-git-send-email-kwan.huen@samsung.com>
Message-ID: <20170811170314.GB7233@localhost.localdomain>

On Thu, Aug 10, 2017@07:54:09PM -0700, kwan.huen@samsung.com wrote:
> Directive is a feature introduced in NVMe v1.3 that allows host
> and NVM subsystem or controller information exchange, namely data
> lifetime hint for example. Information is transmitted using
> the Directive Send and Directive Receive commands.
> 
> This patch set allows control of the directive resources of a
> directive-enabled nvme device.

The patches themselves look great, but I didn't realize this was a
feature user-space should be accessing. Providing this could mess up
the streams the kernel believes are set up, right?
