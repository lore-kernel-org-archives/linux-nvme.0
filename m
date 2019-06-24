From: mskorzhinskiy@solarflare.com (Mikhail Skorzhinskii)
Date: Mon, 24 Jun 2019 22:51:45 +0200
Subject: [PATCH nvme-cli 01/13] Remove superfluous casts
In-Reply-To: <4fbac30a-51f0-95a7-7146-28805103f6a8@acm.org>
References: <20190619173701.8263-1-bvanassche@acm.org>
 <20190619173701.8263-2-bvanassche@acm.org> <87tvcfnw05.fsf@solarflare.com>
 <4fbac30a-51f0-95a7-7146-28805103f6a8@acm.org>
Message-ID: <87sgryogf2.fsf@solarflare.com>

Bart Van Assche <bvanassche at acm.org> writes:
 > How about restoring RHEL 7 compatibility with the (untested) patch
 > below?

It is now tested and it works fine: both compilation on rhel7/non-rhel
and some basic functionality testing.

Thank you.

Mikhail Skorzhinskii
