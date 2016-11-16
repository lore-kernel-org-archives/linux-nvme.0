From: keith.busch@intel.com (Keith Busch)
Date: Wed, 16 Nov 2016 13:35:23 -0500
Subject: Introducing Unit test framework based on nvme-cli
In-Reply-To: <20161116175828.GA1207@infradead.org>
References: <1477550917-6472-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <20161116175828.GA1207@infradead.org>
Message-ID: <20161116183522.GB10050@localhost.localdomain>

On Wed, Nov 16, 2016@09:58:28AM -0800, Christoph Hellwig wrote:
> Stephen, Keith:
> 
> any comments on this test suite?  I'd really like to see this going
> somewhere, as it would make my life a lot easier.

This is awesome. Just a few comments on the documenation.

If we can get the README to list all the dependencies to run, it'd
make it easier on people like me who start with pretty bare-bones Linux
installations. Getting the environment ready required I run:

 $ pip install nose nose2 pep8 flake8

The README also references a 'doc' folder, but it appears to be missing
from the commit.

Otherwise, I like this alot. I can apply it immediately if there's no
objection, and we can add more documentation as follow on commits.
