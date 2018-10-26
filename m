From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 26 Oct 2018 21:56:03 +0000
Subject: [PATCH 3/3] nvme-cli: fix header paths for new structure
In-Reply-To: <20181026201714.GB10403@localhost.localdomain>
References: <20181026170834.23457-1-chaitanya.kulkarni@wdc.com>
 <20181026170834.23457-3-chaitanya.kulkarni@wdc.com>
 <20181026200733.GA10403@localhost.localdomain>
 <9E08CF92-63C8-4D55-AAF7-D1571D4DEF67@wdc.com>,
 <20181026201714.GB10403@localhost.localdomain>
Message-ID: <BYAPR04MB4502B8BAF42930F3B858EE4586F00@BYAPR04MB4502.namprd04.prod.outlook.com>






From: Keith Busch <keith.busch@intel.com>
Sent: Friday, October 26, 2018 1:17 PM
To: Chaitanya Kulkarni
Cc: linux-nvme at lists.infradead.org
Subject: Re: [PATCH 3/3] nvme-cli: fix header paths for new structure
? 
 
On Fri, Oct 26, 2018@08:11:37PM +0000, Chaitanya Kulkarni wrote:
> No but, static analysis tool reported include path warnings, maybe we can ignore these warnings ?

Oh, interesting! It ought to be safe to ignore, but I don't like that
either. Does your analysis tool report issues if you replace the quoted
includes with angle-brackets?

? #include <...>

instead of 

? #include "..." 
    
It still reports warning, but adding include directory to the nvme-cli/  I was able to get rid of the warning.
