From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 25 Oct 2016 05:41:21 -0700
Subject: [NVME-CLI] NVMe Format Issues - HGST Drives
In-Reply-To: <BY2PR0201MB19119DF43362BC07D9F7D9E38FA90@BY2PR0201MB1911.namprd02.prod.outlook.com>
References: <BY2PR0201MB19119DF43362BC07D9F7D9E38FA90@BY2PR0201MB1911.namprd02.prod.outlook.com>
Message-ID: <20161025124121.GB27453@infradead.org>

Hi Zeta,

a format will probably require a longer timeout than the default 60
seconds, try specfing ? --timeout argument with a longer timeout on the
nvme-cli command line.
