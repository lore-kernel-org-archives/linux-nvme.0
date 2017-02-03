From: hch@lst.de (Christoph Hellwig)
Date: Fri,  3 Feb 2017 15:35:54 +0100
Subject: spread MSI(-X) vectors to all possible CPUs
Message-ID: <20170203143600.32307-1-hch@lst.de>

Hi all,

this series changes our automatic MSI-X vector assignment so that it
takes all present CPUs into account instead of all online ones.  This
allows to better deal with cpu hotplug events, which could happen
frequently due to power management for example.
