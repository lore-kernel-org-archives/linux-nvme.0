From: willy@wil.cx (Matthew Wilcox)
Date: Tue, 10 Mar 2015 15:46:29 -0400
Subject: [PATCH] NVMe: Fix error handling of class_create("nvme")
In-Reply-To: <1426015102.18746.10.camel@jpfreyen-mobl5.amr.corp.intel.com>
References: <1425681821-620-1-git-send-email-khoroshilov@ispras.ru>
 <1426015102.18746.10.camel@jpfreyen-mobl5.amr.corp.intel.com>
Message-ID: <20150310194629.GQ2780@wil.cx>

On Tue, Mar 10, 2015@12:18:22PM -0700, J Freyensee wrote:
> Looking at IS_ERR(), it uses IS_ERR_VALUE() which uses unlikely(), which
> from what I understand is a compiler hint that means "this error is
> unlikely to happen".
> 
> Well, is this error unlikely to happen?  Looks like the error could be

Yes.  All errors are, by definition, unlikely to happen.
