From: jonathan.derrick@intel.com (Jon Derrick)
Date: Wed, 1 Jul 2015 10:54:48 -0600
Subject: [PATCHv2 2/2] NVMe: Use CMB for the SQ if available
In-Reply-To: <36F6EBABA23FEF4391AF72944D228901EB289031@BBYEXM02.pmc-sierra.internal>
References: <1435098787-13083-1-git-send-email-jonathan.derrick@intel.com>
 <1435098787-13083-3-git-send-email-jonathan.derrick@intel.com>
 <36F6EBABA23FEF4391AF72944D228901EB289031@BBYEXM02.pmc-sierra.internal>
Message-ID: <20150701165448.GA3290@localhost.localdomain>

Hi Stephen,

Thanks for reviewing

> This seems a little backwards to me in the sense that if the drive advertises CMB with SQ support the host is forced into using the CMB for SQs. Surely the host should have some ability to over-ride what the drive says? At the very least an argument into the  module to ignore CMB capabilities seems appropriate.

That seems like a good idea to allow it to be disabled as a module param

>Ultimately it would be good to have the host have the ability to use its preference when a device is reset. Or am I missing something?

Would using a module param cover your concerns here?
