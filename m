From: scott.bauer@intel.com (Scott Bauer)
Date: Wed, 22 Feb 2017 09:15:51 -0700
Subject: [PATCH] block/sed: Embed function data into the function sequence
In-Reply-To: <1487775313-10188-1-git-send-email-jonathan.derrick@intel.com>
References: <1487775313-10188-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <20170222161551.GB2696@sbauer-Z170X-UD5>

On Wed, Feb 22, 2017@07:55:13AM -0700, Jon Derrick wrote:
> By embedding the function data with the function sequence, we can
> eliminate the external function data and state variable code. It also
> made obvious some other small cleanups.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
Reviewed-by: Scott Bauer <scott.bauer at intel.com>

Christoph's review is here (I don't know if its kosher for me to put it in my message)
http://lists.infradead.org/pipermail/linux-nvme/2017-February/008405.html
