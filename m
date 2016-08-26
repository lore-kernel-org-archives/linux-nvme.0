From: keith.busch@intel.com (Keith Busch)
Date: Fri, 26 Aug 2016 17:45:50 -0400
Subject: [PATCH] nvme-cli/fabrics: Add nr_io_queues parameter to connect
 command
In-Reply-To: <20160826160112.495DFE08C5@smtp.ogc.us>
References: <20160826160112.495DFE08C5@smtp.ogc.us>
Message-ID: <20160826214549.GC19986@localhost.localdomain>

On Fri, Aug 26, 2016@08:56:52AM -0700, Steve Wise wrote:
> Added 'nr_io_queues' to 'connect' command so users can specify the number
> of io queues to allocate.

Purely as a matter of consistency here, every other long-format option
in this program uses dash '-' instead of underscore '_' as a multi-word
separator. Let's stick with that. It works for 'git'. :)
