From: keith.busch@intel.com (Keith Busch)
Date: Wed, 25 Apr 2018 11:56:29 -0600
Subject: [PATCH nvme-cli] fabrics: add option to supply
 keep-alive-timeout for connect-all
In-Reply-To: <20180425174923.9387-1-jthumshirn@suse.de>
References: <20180425174923.9387-1-jthumshirn@suse.de>
Message-ID: <20180425175629.GA454@localhost.localdomain>

On Wed, Apr 25, 2018@11:49:23AM -0600, Johannes Thumshirn wrote:
> Currently we can't supply a keep-alive-timeout when doing a nvme
> connect-all, but we can supply it when doing nvme connect.
> 
> Bring connect-all in line with connect.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>

Applied, thanks!
