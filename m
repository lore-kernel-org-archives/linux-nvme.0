From: kbusch@kernel.org (Keith Busch)
Date: Tue, 9 Apr 2019 15:38:29 -0600
Subject: [PATCH] nvme-cli: Revert stop-on-failure with connect-all
In-Reply-To: <b84a5abd-61d2-c4f0-c4ce-e77791841cfb@gmail.com>
References: <20190409205154.15197-1-jsmart2021@gmail.com>
 <20190409210448.GA3272@localhost.localdomain>
 <b84a5abd-61d2-c4f0-c4ce-e77791841cfb@gmail.com>
Message-ID: <20190409213828.GA3714@localhost.localdomain>

On Tue, Apr 09, 2019@02:25:47PM -0700, James Smart wrote:
> On 4/9/2019 2:04 PM, Keith Busch wrote:
> > Patch applied. I just tagged a release earlier this week, so let me know
> > if this is urgent enough to warrant a new tag.
> > 
> 
> I believe it is unfortunately.  It seems to be a fairly common thing.

Okay, done. There were only 2 other commits fixing trivial bugs since
the last release, so just tagged it with an additional minor number.
