From: hch@lst.de (Christoph Hellwig)
Date: Thu, 14 Jun 2018 14:22:12 +0200
Subject: queue ready fixes and cleanups v2
Message-ID: <20180614122215.4395-1-hch@lst.de>

Changes since v1:
 - fixed the inverted fc ready check 
 - squashed two patches
 - complete redo of the last patch to only allow the connect command on
   a non-live queue in the right states
