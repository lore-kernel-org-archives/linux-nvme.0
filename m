From: keith.busch@intel.com (Keith Busch)
Date: Fri, 6 Oct 2017 09:09:13 -0600
Subject: [PATCH-stable] nvme: protect against simultaneous shutdown
 invocations
In-Reply-To: <20171006150557.17492-1-keith.busch@intel.com>
References: <20171006150557.17492-1-keith.busch@intel.com>
Message-ID: <20171006150912.GA17569@localhost.localdomain>

On Fri, Oct 06, 2017@09:05:57AM -0600, Keith Busch wrote:
> commit 77bf25ea70200cddf083f74b7f617e5f07fac8bd upstream
> 
> Back-ported to 4.4. The only difference is the file location of the
> struct definition that's adding the mutex.

Err, sorry, please disregard this one. There is a mistake in the back
port that will break. Will send out the correct version.
