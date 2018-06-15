From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 15 Jun 2018 02:39:11 -0700
Subject: [PATCH 1/2] nvme-cli: add changed log ns support
In-Reply-To: <20180611020508.2845-1-chaitanya.kulkarni@wdc.com>
References: <20180611020508.2845-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180615093911.GE10928@infradead.org>

Needs a least a bit of a changelog.

What is the use case given that this is mostly something for the
driver to look into given that self-clearing nature.
