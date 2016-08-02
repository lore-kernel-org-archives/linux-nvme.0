From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 2 Aug 2016 11:57:25 -0400
Subject: [PATCH 0812/1285] Replace numeric parameter like 0444 with macro
In-Reply-To: <3d93cf14-6171-b4b7-f204-6b1148e5849f@grimberg.me>
References: <20160802114854.4100-1-baolex.ni@intel.com>
 <3d93cf14-6171-b4b7-f204-6b1148e5849f@grimberg.me>
Message-ID: <20160802155725.GA6066@home.goodmis.org>

On Tue, Aug 02, 2016@04:29:53PM +0300, Sagi Grimberg wrote:
> I assume that you didn't try to send a 1285 patches set :)

No he actually did. And some of us were unfortunate enough to be Cc'd on a
hundred of them.

> 
> I think you can safely squash the two patches together.

I've NAKed all patches I was Cc'd on. IMNSHO the change makes it less readable
and more error prone.

-- Steve
