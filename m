From: rosattig@linux.vnet.ibm.com (Rodrigo Rosatti Galvao)
Date: Mon, 2 Apr 2018 13:31:33 -0300
Subject: [PATCH v2] nvmet: fix nvmet_execute_write_zeroes function
In-Reply-To: <20180402145813.GE28945@localhost.localdomain>
References: <1522680581-10220-1-git-send-email-rosattig@linux.vnet.ibm.com>
 <20180402145813.GE28945@localhost.localdomain>
Message-ID: <10c64856-15bf-eed8-c9db-33b4d9ea58f3@linux.vnet.ibm.com>

> I'm terribly sorry, but the +1 actually needs to be outside the
> le16_to_cpu. The above will work on little-endian machines, but not big.

No problem at all. Thank you for helping on this.

I'm going to send a V3 with this change.

-- 
Rodrigo R. Galv?o
Intern - Linux Technology Center - IBM
