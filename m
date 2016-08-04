From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Thu, 04 Aug 2016 10:46:48 -0700
Subject: [PATCH] nvmet: Fix controller serial number inconsistency
In-Reply-To: <1470306879-5196-1-git-send-email-sagi@grimberg.me>
References: <1470306879-5196-1-git-send-email-sagi@grimberg.me>
Message-ID: <1470332808.19927.24.camel@linux.intel.com>

On Thu, 2016-08-04@13:34 +0300, Sagi Grimberg wrote:
> The host is allowed to issue identify as many times
> as it wants, we need to stay consistent when reporting
> the serial number for a given controller.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>?

Looks good,

Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
