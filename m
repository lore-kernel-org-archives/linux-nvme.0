From: axboe@fb.com (Jens Axboe)
Date: Mon, 6 Feb 2017 17:46:22 -0700
Subject: No subject
In-Reply-To: <1486426969-27549-1-git-send-email-scott.bauer@intel.com>
References: <1486426969-27549-1-git-send-email-scott.bauer@intel.com>
Message-ID: <945ef3e3-41bf-60ac-f929-7e3eb7aea318@fb.com>

On 02/06/2017 05:22 PM, Scott Bauer wrote:
> I screwed up and had size_t's in the uapi structures which of course
> differ in size on 32 and 64 bit platforms. This caused issues running
> 32 bit userland on a 64 bit kernel. We're hoping to sneak this
> patch in so we don't have to maintain a compat layer.

I'll apply it - you forgot to add a Fixes, always do that when a patch
fixes something that a specific commit introduced.

-- 
Jens Axboe
