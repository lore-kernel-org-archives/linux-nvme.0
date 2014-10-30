From: keith.busch@intel.com (Keith Busch)
Date: Thu, 30 Oct 2014 13:31:38 +0000 (UTC)
Subject: [PATCH] nvme-user: Minor enhancement and fixes
In-Reply-To: <1414664449-3288-1-git-send-email-s.chawdhary@samsung.com>
References: <1414664449-3288-1-git-send-email-s.chawdhary@samsung.com>
Message-ID: <alpine.LNX.2.00.1410301321520.4225@localhost.lm.intel.com>

Hi Swati,

On Thu, 30 Oct 2014, Swati C wrote:
> Not sure what's the correct forum for nvme-user patches, hence posting them here.

I think it should be okay to post these here.

> Also, it appears that nvme-user is not actively maintained anymore. Is there any plan for the same?

I do maintain it, but if no one requests anything new or submits patches,
it'll be pretty low maintenance. :) I personally don't plan to add new
features until 1.2 capable devices are more available.

> Minor enhancement & fixes to nvme-user utils.
> - nvme_smart
>  - GetLogPage CDW10 is a 0's based value.

Olivier actually reported this a couple months ago and was fixed:

http://git.infradead.org/users/kbusch/nvme-user.git/commitdiff/135b3b791702b976e3c5ba7d1a7265357f3e25db?hp=e81ba0099002279c940c655f5a26ecfd436eb1c9

> - nvme_format_ns
>  - Secure Erase Settings(SES) support.

I'm okay with adding erase settings.

>  - During Format, if LBA Format Metadata Size(MS) is 0, set Metadata Settings to Extended LBA.

Why? This is what sets identify namespace's FLBAS bit 4. The 1.1b spec
clarified this bit is not applicable when metadata size is 0.
