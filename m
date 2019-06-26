From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Wed, 26 Jun 2019 17:54:58 -0300
Subject: [RFC PATCH 00/28] Removing struct page from P2PDMA
In-Reply-To: <CAPcyv4hCNoMeFyOE588=kuNUXaPS-rzaXnF2cN2TFejso1SGRw@mail.gmail.com>
References: <20190624072752.GA3954@lst.de>
 <558a27ba-e7c9-9d94-cad0-377b8ee374a6@deltatee.com>
 <20190625072008.GB30350@lst.de>
 <f0f002bf-2b94-cd18-d18f-5d0b08311495@deltatee.com>
 <20190625170115.GA9746@lst.de>
 <41235a05-8ed1-e69a-e7cd-48cae7d8a676@deltatee.com>
 <20190626065708.GB24531@lst.de>
 <c15d5997-9ba4-f7db-0e7a-a69e75df316c@deltatee.com>
 <20190626202107.GA5850@ziepe.ca>
 <CAPcyv4hCNoMeFyOE588=kuNUXaPS-rzaXnF2cN2TFejso1SGRw@mail.gmail.com>
Message-ID: <20190626205458.GA6392@ziepe.ca>

On Wed, Jun 26, 2019@01:39:01PM -0700, Dan Williams wrote:
> Hmm, that sounds like dev_pagemap without the pages.

Yes, and other page related overhead. Maybe both ideas can exist in
the pagemap code?

All that is needed here is to map a bar phys_addr_t to some 'bar info'
that helps the mapping.

Jason
