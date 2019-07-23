from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, Text

Base = declarative_base()

class Comment(Base):
    __tablename__ = 'comment'
    
    id = Column(Integer, primary_key=True)
    comment = Column(Text)
    
engine = create_engine('sqlite:///BENM.db')
Base.metadata.create_all(engine)
Session = sessionmaker(bind=engine)
