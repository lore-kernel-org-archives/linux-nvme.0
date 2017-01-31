From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 31 Jan 2017 11:32:24 -0700
Subject: [PATCH 1/1] MicroSemi Switchtec management interface driver
In-Reply-To: <20170131104916.0f187309@lwn.net>
References: <1485882204-26947-1-git-send-email-logang@deltatee.com>
 <1485882204-26947-2-git-send-email-logang@deltatee.com>
 <20170131172630.GB12595@kroah.com>
 <57658098-b24a-cb25-b2e3-ccf8fcbf8fe5@deltatee.com>
 <20170131104916.0f187309@lwn.net>
Message-ID: <cb0beb92-3f7e-e661-d6c4-430ba1a09b78@deltatee.com>



On 31/01/17 10:49 AM, Jonathan Corbet wrote:
> The good news is that your switchtec.txt file is already 99% in the RST
> format, so there is little or nothing to do there.
> 
> The bad news is that we don't quite have a place for it yet.  This is
> really user-space developer documentation, and we don't have a sub-book
> for that.  I expect that to change pretty soon, and I might even toss
> together a bare beginning for 4.11, but that hasn't happened yet.
> 
> If you would like to learn the ropes and make one, that would be more than
> great :)  Alternatively, I'd suggest just leaving the document as-is, and
> I'll put it toward the top of the list of things to move into place once I
> get that book started.

Thanks Jon. I took a look at the documentation and it doesn't look too
difficult. But I don't really feel qualified to make some of the
decisions necessary to create the new book. (ie names, locations, etc.)
And I don't really want that churn in this patchset. So we'll leave it
where it is for now.

I have cleaned up some of the RST format for v2 though.

Logan
