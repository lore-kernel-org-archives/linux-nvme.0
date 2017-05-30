From: hch@lst.de (Christoph Hellwig)
Date: Tue, 30 May 2017 11:24:42 +0200
Subject: [PATCH 2/7] nvmet: add uuid field to nvme_ns and populate via
 configfs
In-Reply-To: <4aecbc794651073b2812341dc63e1f2918cc6a82.1496131397.git.jthumshirn@suse.de>
References: <cover.1496131397.git.jthumshirn@suse.de>
 <4aecbc794651073b2812341dc63e1f2918cc6a82.1496131397.git.jthumshirn@suse.de>
Message-ID: <20170530092442.GA16736@lst.de>

This should be stored as a uuid_t (or rather uuid_be in the current
kernel, but I'm about to rename it), and use uuid_be_to_bin / uuid_to_bin
for parsing.
