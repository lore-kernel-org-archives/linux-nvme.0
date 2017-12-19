From: keith.busch@intel.com (Keith Busch)
Date: Tue, 19 Dec 2017 13:19:59 -0700
Subject: [PATCH V2 0/3] nvme-cli: update Firmware Activate to Firmware
 Commit
In-Reply-To: <1513504682-30766-1-git-send-email-minwoo.im.dev@gmail.com>
References: <1513504682-30766-1-git-send-email-minwoo.im.dev@gmail.com>
Message-ID: <20171219201959.GA23384@localhost.localdomain>

On Sun, Dec 17, 2017@06:58:02PM +0900, Minwoo Im wrote:
> This patch set will make it support alias of every subcommands in nvme-cli.
> To show how this is done, update "Firmware Activate" command to
> "Firmware Commit" by making it as an alias.
> Also it updates "Firmware Commit" command to support boot partition feature
> which was introduced in NVMe 1.3 spec.
> 
> Please feel free to give feedbacks and reviews.
> 
> Changes to V1:
> - add support alias infrastructure for subcommands (Keith)

Thanks, this all looks good to me. Applied.
