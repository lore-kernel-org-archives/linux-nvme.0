From: sbates@raithlin.com (Stephen  Bates)
Date: Fri, 13 Apr 2018 21:50:52 +0000
Subject: [RFC PATCH 8/8] nvmet: add configfs interface for target passthru
In-Reply-To: <12238d4c-c01d-9590-2357-dbeabff23dfc@deltatee.com>
References: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
 <20180330065747.20962-9-chaitanya.kulkarni@wdc.com>
 <be832a05-3906-7087-30ed-f20784128272@deltatee.com>
 <20180413173004.GC23674@lst.de>
 <12238d4c-c01d-9590-2357-dbeabff23dfc@deltatee.com>
Message-ID: <E0D61051-1A69-4379-B683-4EC0B2498C4E@raithlin.com>

> Yes. It only really requires one field (the path to the nvme char
> device) and making it exclusive to namespaces doesn't seem that
> unintuitive. 

I have to agree. Creating a whole new tree for passthru seems a lot less intuitive than adding a single passthru field to the subsystem tree.

> (compared to a whole new top level directory named 'pt'). 

Pretty please can we call it passthru? pt is totally incompressible to the casual reader...

BTW we did test this series on one of our x86_64 target setups and it did a great job passing our vendor specific admin commands through to the NVMe namespaces.

Tested-By: Stephen Bates <sbates at raithlin.com>

Stephen
