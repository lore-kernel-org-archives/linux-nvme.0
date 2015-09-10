From: keith.busch@intel.com (Keith Busch)
Date: Thu, 10 Sep 2015 13:48:01 +0000 (UTC)
Subject: [PATCH] Increase the max transfer size when mdts is 0
In-Reply-To: <1441884544-10183-1-git-send-email-sathya.m@samsung.com>
References: <1441884544-10183-1-git-send-email-sathya.m@samsung.com>
Message-ID: <alpine.LNX.2.00.1509101347280.23840@localhost.lm.intel.com>

On Thu, 10 Sep 2015, Sathyavathi M wrote:
> From: Sathyavathi M <sathya.m at samsung.com>
>
> This patch address the issue when IO with 128KB from FIO is splitted as two
> parts, 124KB and 4KB due to max transfer size(127KB).This degrades the device
> performance.
>
> Signed-off-by: Sathyavathi M <sathya.m at samsung.com>

Acked-by: Keith Busch <keith.busch at intel.com>
