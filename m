From: keith.busch@intel.com (Keith Busch)
Date: Fri, 30 Nov 2018 08:37:16 -0700
Subject: [GIT PULL] nvme fixes for 4.20
In-Reply-To: <01b6314c-903e-6787-ccf6-e93aa789199a@kernel.dk>
References: <20181130152430.GA3107@infradead.org>
 <01b6314c-903e-6787-ccf6-e93aa789199a@kernel.dk>
Message-ID: <20181130153716.GA10660@localhost.localdomain>

On Fri, Nov 30, 2018@08:26:24AM -0700, Jens Axboe wrote:
> On 11/30/18 8:24 AM, Christoph Hellwig wrote:
> > Various fixlets all over, including throwing in a 'default y' for the
> > multipath code, given that we want people to actually enable it for full
> > functionality.
> 
> Why enable it by default? 99.9% of users aren't going to care. That
> seems like an odd choice.

I'm okay with making it the default, but can we move this to 4.21 please?
