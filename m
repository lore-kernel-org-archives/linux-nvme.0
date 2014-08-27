From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 27 Aug 2014 15:34:26 -0400
Subject: Slower operations with NVMe and MD
In-Reply-To: <alpine.LRH.2.03.1408271246050.4696@AMR> (Keith Busch's message
 of "Wed, 27 Aug 2014 12:55:17 -0600 (MDT)")
References: <CALu-fzszdzo116Ma7-grG0pfhB8L7QUUMinooy-RF5tqw8m+OA@mail.gmail.com>
 <alpine.LRH.2.03.1408271246050.4696@AMR>
Message-ID: <yq1mwapiv5p.fsf@sermon.lab.mkp.net>

>>>>> "Keith" == Keith Busch <keith.busch at intel.com> writes:

Keith> Since we're a bio-based driver, we don't get the benefits of
Keith> merging.

Yeah, in the request-based case we'd be merging those split MD requests
back together.

-- 
Martin K. Petersen	Oracle Linux Engineering
