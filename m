From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 30 Aug 2017 05:56:49 -0700
Subject: [PATCH V4] nvmet: Add support for HOST_ID feature.
In-Reply-To: <1504095779-13255-1-git-send-email-omri@excelero.com>
References: <1504095779-13255-1-git-send-email-omri@excelero.com>
Message-ID: <20170830125649.GA15032@infradead.org>

> -	switch (cdw10 & 0xf) {
> +	switch (cdw10 & 0xff) {

This is a new change compared to the previous one.  It looks correct
to me as we need the bigger mask, but it should have been documented
in the changelog.  I'll fix it up and apply the patch.
