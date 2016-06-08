From: keith.busch@intel.com (Keith Busch)
Date: Wed, 8 Jun 2016 10:52:42 -0400
Subject: nvme-cli documentation question
In-Reply-To: <20160608131036.GA10503@infradead.org>
References: <20160608131036.GA10503@infradead.org>
Message-ID: <20160608145241.GC1430@localhost.localdomain>

On Wed, Jun 08, 2016@06:10:36AM -0700, Christoph Hellwig wrote:
> It seems like nvme-cli generate the html and man page version of the
> documentation from the .txt files.  Any reason the generated files
> are checked in?  How are they generated, and how is the process for
> them handled?

While I wouldn't mind having only the .txt, the build artifacts are
committed to version control because some people using this project
couldn't install asciidoc to generate the man pages, so they're included
for convenience.
