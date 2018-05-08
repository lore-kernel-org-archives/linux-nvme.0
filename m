From: keith.busch@linux.intel.com (Keith Busch)
Date: Tue, 8 May 2018 10:35:39 -0600
Subject: [PATCH v3] nvme: add quirk to force medium priority for SQ
 creation
In-Reply-To: <672a97be-7fbf-b21e-9f75-2c18e64ccf8f@kernel.dk>
References: <672a97be-7fbf-b21e-9f75-2c18e64ccf8f@kernel.dk>
Message-ID: <20180508163539.GB31027@localhost.localdomain>

On Tue, May 08, 2018@10:25:15AM -0600, Jens Axboe wrote:
> Some P3100 drives have a bug where they think WRRU (weighted round
> robin) is always enabled, even though the host doesn't set it. Since
> they think it's enabled, they also look at the submission queue
> creation priority. We used to set that to MEDIUM by default,
> but that was removed in commit 81c1cd98351b. This causes various
> issues on that drive. Add a quick to still set MEDIUM priority
> for that controller.
> 
> Fixes: 81c1cd98351b ("nvme/pci: Don't set reserved SQ create flags")
> Cc: stable at vger.kernel.org
> Signed-off-by: Jens Axboe <axboe at kernel.dk>

Thanks, applied to nvme-4.18.
