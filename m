From: keith.busch@intel.com (Keith Busch)
Date: Fri, 26 Oct 2018 14:17:14 -0600
Subject: [PATCH 3/3] nvme-cli: fix header paths for new structure
In-Reply-To: <9E08CF92-63C8-4D55-AAF7-D1571D4DEF67@wdc.com>
References: <20181026170834.23457-1-chaitanya.kulkarni@wdc.com>
 <20181026170834.23457-3-chaitanya.kulkarni@wdc.com>
 <20181026200733.GA10403@localhost.localdomain>
 <9E08CF92-63C8-4D55-AAF7-D1571D4DEF67@wdc.com>
Message-ID: <20181026201714.GB10403@localhost.localdomain>

On Fri, Oct 26, 2018@08:11:37PM +0000, Chaitanya Kulkarni wrote:
> No but, static analysis tool reported include path warnings, maybe we can ignore these warnings ?

Oh, interesting! It ought to be safe to ignore, but I don't like that
either. Does your analysis tool report issues if you replace the quoted
includes with angle-brackets?

  #include <...>

instead of 

  #include "..." 
