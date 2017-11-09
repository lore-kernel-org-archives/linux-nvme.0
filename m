From: hch@lst.de (Christoph Hellwig)
Date: Thu, 9 Nov 2017 10:33:21 +0100
Subject: [PATCH v2 0/4] qla2xxx: Add FC-NVMe Target support
In-Reply-To: <20171109031754.10270-1-himanshu.madhani@cavium.com>
References: <20171109031754.10270-1-himanshu.madhani@cavium.com>
Message-ID: <20171109093321.GA17246@lst.de>

Before even looking at the patches:  they seem to add a lot of new
sparse warnings, mostly about endianess issues.  Given that FC-NVMe
is a mix of BE and LE structures getting this right is important.
Please fix them up first.
