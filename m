From: hch@lst.de (Christoph Hellwig)
Date: Tue, 2 Jul 2019 16:25:33 +0200
Subject: [PATCH] nvme: fix multipath crash when ANA deactivated
In-Reply-To: <1229162251.30096937.1562061155630.JavaMail.zimbra@kalray.eu>
References: <708068303.29979589.1561975811341.JavaMail.zimbra@kalray.eu>
 <6416b503-aa20-0094-6acf-101c60e9e3c9@suse.de>
 <1229162251.30096937.1562061155630.JavaMail.zimbra@kalray.eu>
Message-ID: <20190702142533.GA16763@lst.de>

On Tue, Jul 02, 2019@11:52:35AM +0200, Marta Rybczynska wrote:
> > They idea was to use a 'ana_log_buf == NULL' as an indicator that ANA is
> > disabled, so there is no need to have an additional flag.
> 
> OK, still keeping the split of the helper functions?

I think we can simplify switch nvme_ctrl_use_ana to only check for
->ana_log_buf, and just opencode the actual capabilities check in
the setup path.
