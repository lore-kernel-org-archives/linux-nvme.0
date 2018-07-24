From: hch@lst.de (Christoph Hellwig)
Date: Tue, 24 Jul 2018 19:41:04 +0200
Subject: [PATCH 2/3] block: move dif_prepare/dif_complete functions to
 block layer
In-Reply-To: <2fdb170d-e8de-b7cc-429a-9b6e5f36de86@mellanox.com>
References: <1532439222-5668-1-git-send-email-maxg@mellanox.com>
 <1532439222-5668-2-git-send-email-maxg@mellanox.com>
 <20180724135546.GB29918@lst.de>
 <2fdb170d-e8de-b7cc-429a-9b6e5f36de86@mellanox.com>
Message-ID: <20180724174104.GA1791@lst.de>

> /**
>  * t10_pi_prepare() - prepate PI prior submitting request to device

no need for the braces here.

>
>  * @rq:               request with PI that should be prepared
>  * @protection_type:  PI type (Type 1/Type 2/Type 3)
>  *
>  * Description:

No need for the description tag either (although I don't think it
is actively harmful)
