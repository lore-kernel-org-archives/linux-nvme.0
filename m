From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 13 May 2015 12:49:45 -0400
Subject: [PATCH] block:Remove including of the header file, linux/mm.h
 for the file,nvme-core.c
In-Reply-To: <1431534078-17740-1-git-send-email-xerofoify@gmail.com>
References: <1431534078-17740-1-git-send-email-xerofoify@gmail.com>
Message-ID: <20150513164945.GX4003@linux.intel.com>

On Wed, May 13, 2015@12:21:18PM -0400, Nicholas Krause wrote:
> This removes the include statement for including the header file,
> linux/mm.h in the file, nvme-core.c due this driver file never
> calling any functions from the header file, linux/mm.h  and
> only adding bloat to this driver by including this unnessary
> header file.

Nick, I'm not going to apply this patch, simply because the effort of
verifying that you haven't made a mistake is greater than the gain we
might get from applying it.  Your earlier patch shows that you haven't
actually learned anything since I first heard about your patches.
Please, continue learning before submitting more patches.
